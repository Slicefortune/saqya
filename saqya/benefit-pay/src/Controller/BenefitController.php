<?php

namespace BenefitPay\Controller;

use App\Http\Controllers\Controller;
use BenefitPay\Model\BenefitPayTransaction;
use BenefitPay\Service\iPayBenefitPipe;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class BenefitController extends Controller
{
    /**
     * This method is responsible for validation of payment gateway
     *
     * @param Request $request
     * @return void
     */
    public function benefitValidate(Request $request)
    {
        $trandata = isset($_POST["trandata"]) ? $_POST["trandata"] : "";
        if ($trandata != "") {
            $Pipe = new iPayBenefitPipe();
            $Pipe->setkey(env('BENEFIT_TERMINAL_RESOURCE_KEY'));
            $Pipe->settrandata($trandata);
            $returnValue = $Pipe->parseResponseTrandata();
            if ($returnValue == 1) {
                if ($Pipe->getresult() == "CAPTURED") {
                    echo("REDIRECT=" . url('benefit/approved'));
                } elseif ($Pipe->getresult() == "NOT CAPTURED" || $Pipe->getresult() == "CANCELED" || $Pipe->getresult() == "DENIED BY RISK" || $Pipe->getresult() == "HOST TIMEOUT") {
                    echo "REDIRECT=" . url('benefit/error');
                } else {
                    //Unable to process transaction temporarily. Try again later or try using another card.
                    echo "REDIRECT=" . url('benefit/error');
                }
            } else {
                echo "REDIRECT=" . url('benefit/error');
            }
        } else {
            echo "REDIRECT=" . url('benefit/error');
        }
    }

    /**
     * Benefit Payment proceeded and approved
     *
     * @param Request $request
     * @return RedirectResponse|Response
     */
    public function approved(Request $request)
    {
        try {
            DB::beginTransaction();
            $code = isset($request->trandata) ? $request->trandata : "";
            $result = $this->decryptPayment($code);
            $result->trans_date = date('Y-m-d', strtotime($result->date));
            $payment = BenefitPayTransaction::where('trackId', $result->trackId)->first();
            $payment->update([
                'status' => 'Success',
                'return_response' => json_encode($result)
            ]);
            DB::commit();
            // here we will have custom logic to update order status
            $handler = config('benefit.handler');
            $handler = new $handler;
            return $handler->handleSuccessFullPayment($payment);

        } catch (\Exception $exception) {
            DB::rollback();
            report($exception);
            return response()->view('errors.500', [
                'message' =>  "Something went wrong while processing your payment! Please contact Administrator"
            ], 500);
        }

    }

    /**
     * Error on Payment
     *
     * @param Request $request
     * @return Response
     */
    public function error(Request $request)
    {
        try {
            DB::beginTransaction();
            $response = "Unknown error";
            $trandata = $_POST["trandata"] ?? "";
            $result = [];
            if(isset($_POST["trandata"])) {
                $Pipe = new iPayBenefitPipe();
                $Pipe->setkey(env('BENEFIT_TERMINAL_RESOURCE_KEY'));
                $Pipe->settrandata($trandata);
                $returnValue = $Pipe->parseResponseTrandata();
                if ($returnValue == 1) {
                    if ($Pipe->getresult() == "NOT CAPTURED") {
                        switch ($Pipe->getAuthRespCode()) {
                            case "05":
                                $response = "Please contact issuer";
                                break;
                            case "14":
                                $response = "Invalid card number";
                                break;
                            case "33":
                                $response = "Expired card";
                                break;
                            case "36":
                                $response = "Restricted card";
                                break;
                            case "38":
                                $response = "Allowable PIN tries exceeded";
                                break;
                            case "51":
                                $response = "Insufficient funds";
                                break;
                            case "54":
                                $response = "Expired card";
                                break;
                            case "55":
                                $response = "Incorrect PIN";
                                break;
                            case "61":
                                $response = "Exceeds withdrawal amount limit";
                                break;
                            case "62":
                                $response = "Restricted Card";
                                break;
                            case "65":
                                $response = "Exceeds withdrawal frequency limit";
                                break;
                            case "75":
                                $response = "Allowable number PIN tries exceeded";
                                break;
                            case "76":
                                $response = "Ineligible account";
                                break;
                            case "78":
                                $response = "Refer to Issuer";
                                break;
                            case "91":
                                $response = "Issuer is inoperative";
                                break;
                            default:
                                // for unlisted values, please generate a proper user-friendly message
                                $response = "Unable to process transaction temporarily. Try again later or try using another card.";
                                break;
                        }
                    } elseif ($Pipe->getresult() == "CANCELED") {
                        $response = "Transaction was canceled by user.";
                    } elseif ($Pipe->getresult() == "DENIED BY RISK") {
                        $response = "Maximum number of transactions has exceeded the daily limit.";
                    } elseif ($Pipe->getresult() == "HOST TIMEOUT") {
                        $response = "Unable to process transaction temporarily. Try again later.";
                    }

                }
            } else {
                $response = $request->ErrorText ?? 'Unknown Error';
                $result = $request->all();
            }

            $result['trans_date'] = date('Y-m-d', strtotime($request->date ?? now()));
            $payment = BenefitPayTransaction::where('trackId', $request->trackid)->first();
            $result['response_translated'] = $response;

            $payment->update([
                'status' => 'Failed',
                'return_response' => json_encode($result)
            ]);
            DB::commit();

            $handler = config('benefit.handler');
            $handler = new $handler;

            return $handler->handleFailedPayment($payment);

        } catch (\Exception $exception) {
            DB::rollback();
            report($exception);
        }



    }

    /**
     * Decrypt Payment Response
     *
     * @param $code
     * @return mixed
     */
    public function decryptPayment($code)
    {
        $ben = new iPayBenefitPipe();
        $key = env('BENEFIT_TERMINAL_RESOURCE_KEY');
        $code = $ben->hex2ByteArray(trim($code));
        $code = $ben->byteArray2String($code);
        $iv = "PGKEYENCDECIVSPC";
        $code = base64_encode($code);
        $decrypted = openssl_decrypt(
            $code,
            'AES-256-CBC',
            $key,
            OPENSSL_ZERO_PADDING,
            $iv
        );
        $res = json_decode(urldecode($ben->pkcs5_unpad($decrypted)));
        return $res[0];
    }

     public function handleSuccessFullPayment(BenefitPayTransaction $payment)
     {
         return 'Create a method and handle it';
     }
     public function handleFailedPayment(BenefitPayTransaction $payment)
     {
         return 'Create a method and handle it';
     }
}

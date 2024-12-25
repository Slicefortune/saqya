<?php

namespace BenefitPay\Service;

use BenefitPay\Model\BenefitPayTransaction;
use Exception;
use Illuminate\Http\RedirectResponse;

class BenefitService
{
    /**
     * @param $data
     * @return array|null
     * @throws Exception
     */
    public function initiateSession($data): ?array
    {

        $trackId = time() . rand(pow(10, 5 - 1), pow(10, 5) - 1);
        $Pipe = new iPayBenefitPipe();
        $Pipe->setaction("1");
        $Pipe->setcardType("D");
        $Pipe->setcurrencyCode("048");
        $Pipe->settrackId($trackId);
        $Pipe->setamt($data['amount']);

        $isSuccess = $Pipe->performeTransaction();
        $transaction = BenefitPayTransaction::query()->create([
            'trackId' => $trackId,
            'amount' => $data['amount'],
            'status' => BenefitPayTransaction::STATUS_PENDING,
            'order_request' => $data['request_data'] ?? '',
            'cart_data' => (array)$data['cart_data'] ?? '',
        ]);
        if ($isSuccess == 1) {
            return [
                // "transaction" => $transaction,
                // "redirect_url" => $Pipe->getresult(),
                "redirect_url" => 'helo'

            ];
        }

        throw new Exception($Pipe->geterror() . ' | Error Text: ' . $Pipe->geterrorText());
    }
}

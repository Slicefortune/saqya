<?php

namespace App\Http\Controllers;

use App\Models\Donation;
use BenefitPay\Model\BenefitPayTransaction;
use Carbon\Carbon;
use Exception;

class BenefitController extends \BenefitPay\Controller\BenefitController
{

    public function handleSuccessFullPayment(BenefitPayTransaction $payment)
    {

        try {
            $donation = new Donation();
            $donation->product_id = $payment->cart_data['product_id'];
            $donation->mosque_name = $payment->cart_data['mosque_name'];
            $donation->mosque_address = $payment->cart_data['mosque_address'];
            $donation->payment_method = 1;
            $donation->total = $payment->cart_data['total'];
            $donation->sub_total = $payment->cart_data['total'];
            $donation->quantity = $payment->cart_data['quantity'];
            $donation->receiver_name = $payment->cart_data['receiver_name'] ?? null;
            $donation->receiver_contact = $payment->cart_data['receiver_contact']  ?? null;
            $donation->description = $payment->cart_data['description'] ?? null;
            $donation->donated_at = Carbon::now();
            $donation->save();
            return redirect()->to(route('order-placed'));
        } catch (Exception $e) {
            return response()->json([$e], 403);
        }
    }

    public function handleFailedPayment(BenefitPayTransaction $payment)
    {
        return response()->view('errors.500', [
            'message' =>  "Something went wrong while processing your payment! Please contact Administrator. Payment Failed due to : "
                . $payment->return_response->response_translated
        ]);
    }
}

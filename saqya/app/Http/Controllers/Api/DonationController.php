<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\DonationRequest;
use App\Jobs\SendMail;
use App\Models\Donation;
use App\Notifications\NewDonationNotification;
use BenefitPay\Service\BenefitService;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class DonationController extends Controller
{
  /**
   * @var BenefitService $benefitService
   */
  private BenefitService $benefitService;

  /**
   * constructor
   */
  public function __construct(BenefitService $benefitService)
  {
    $this->benefitService = $benefitService;
  }

  public function place_donation(DonationRequest $request): JsonResponse
  {
    $dispatchData = [
      'cart_data' => $request->all(),
      'amount' => $request->total,
      'mail_to' => 'isr4r.ahm3d@gmail.com',
      'subject' => 'New Donation',
      'donation_date' => Carbon::now(),

    ];


  SendMail::dispatch($dispatchData);    // $initaitePayment = $this->benefitService->initiateSession($data);
    return response()->json('Done');
   
  }
}

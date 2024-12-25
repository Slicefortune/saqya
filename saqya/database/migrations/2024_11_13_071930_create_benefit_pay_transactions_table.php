<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBenefitPayTransactionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('benefit_pay_transactions', function (Blueprint $table) {
            $table->id();
            $table->string('trackId')->nullable();
            $table->decimal('amount', 10, 3);
            $table->text('return_response')->nullable();
            $table->enum('status', ['pending', 'success', 'failed'])->default('pending');
            $table->text('order_request');
            $table->text('cart_data');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('benefit_pay_transactions');
    }
}

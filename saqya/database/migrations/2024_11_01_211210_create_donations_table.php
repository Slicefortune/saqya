<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('donations', function (Blueprint $table) {
            $table->id();
            
            $table->string('receiver_name')->nullable();
            $table->string('receiver_contact')->nullable();
            $table->text('description')->nullable();

            $table->string('mosque_name')->nullable();
            $table->text('mosque_address')->nullable();

            $table->integer('quantity')->default(0);
            $table->decimal('sub_total')->default(0);
            $table->decimal('vat')->default(0);
            $table->decimal('commission')->default(0);

            $table->decimal('total')->default(0);
            $table->dateTime('donated_at');
            $table->smallInteger('payment_method');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('donations');
    }
};

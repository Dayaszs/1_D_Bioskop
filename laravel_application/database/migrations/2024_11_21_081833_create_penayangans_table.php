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
        Schema::create('penayangans', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_film');
            $table->foreignId('id_sesi');
            $table->foreignId('id_studio');
            $table->integer('nomor_kursi_tersedia');
            $table->integer('nomor_kursi_terpakai');
            $table->decimal('harga_tiket', 10, 2);
            $table->string('status');
            $table->date('tanggal_tayang');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('penayangans');
    }
};

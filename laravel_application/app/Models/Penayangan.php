<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Penayangan extends Model
{
    protected $fillable = [
        'id_film',
        'id_sesi',
        'id_studio',
        'nomor_kursi_tersedia',
        'nomor_kursi_terpakai',
        'harga_tiket',
        'status',
        'tanggal_tayang',
    ];

    // // Relationship to Film
    // public function film()
    // {
    //     return $this->belongsTo(Film::class, 'id_film');
    // }

    // // Relationship to Sesi
    // public function sesi()
    // {
    //     return $this->belongsTo(Sesi::class, 'id_sesi');
    // }

    // // Relationship to Studio
    // public function studio()
    // {
    //     return $this->belongsTo(Studio::class, 'id_studio');
    // }
}

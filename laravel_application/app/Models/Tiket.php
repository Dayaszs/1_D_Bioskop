<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tiket extends Model
{
    use HasFactory;

    protected $table = 'tikets';
    protected $primaryKey = 'id_tiket';

    protected $fillable = [
        'id_user',
        'id_penayangan',
        'nomor_kursi'
    ];

    // public function penayangan()
    // {
    //     return $this->belongsTo(Penayangan::class, 'id_penayangan', 'id_penayangan');
    // }

    // public function review()
    // {
    //     return $this->hasOne(Review::class, 'id_tiket', 'id_tiket');
    // }
}

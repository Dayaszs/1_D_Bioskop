<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Review extends Model
{
    use HasFactory;

    protected $table = 'reviews';
    protected $primaryKey = 'id_review';

    protected $fillable = [
        'id_tiket',
        'rating'
    ];

    // Relasi ke Tiket
//     public function tiket()
//     {
//         return $this->belongsTo(Tiket::class, 'id_tiket', 'id_tiket');
//     }
}

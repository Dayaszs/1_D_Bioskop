<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Film extends Model
{
    use HasFactory;

    protected $table = 'films';
    protected $primaryKey = 'id_film';

    protected $fillable = [
        'judul',
        'genre',
        'tahun_rilis',
        'sutradara',
        'aktor',
        'deskripsi'
    ];

    // public function penayangans()
    // {
    //     return $this->hasMany(Penayangan::class, 'id_film', 'id_film');
    // }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Studio extends Model
{
    use HasFactory;

    protected $table = 'studios';
    protected $primaryKey = 'id_studio';

    protected $fillable = [
        'nama_studio',
        'kapasitas'
    ];

    // public function penayangans()
    // {
    //     return $this->hasMany(Penayangan::class, 'id_studio', 'id_studio');
    // }
}

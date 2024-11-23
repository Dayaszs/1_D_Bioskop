<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SesiTayang extends Model
{
    use HasFactory;

    protected $table = 'sesis';
    protected $primaryKey = 'id_sesi';

    protected $fillable = [
        'jam_mulai',
        'jam_selesai'
    ];

    // public function penayangans()
    // {
    //     return $this->hasMany(Penayangan::class, 'id_sesi', 'id_sesi');
    // }
}

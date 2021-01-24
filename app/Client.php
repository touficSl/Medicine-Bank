<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Client extends Model
{
    public $additional_attributes = ['full_name'];

    public function getFullNameAttribute()
    {
        return "{$this->first_name_ar} {$this->father_name_ar} {$this->last_name_ar}";
    }
}

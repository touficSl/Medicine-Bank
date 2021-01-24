<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Medication extends Model
{
    public $additional_attributes = ['full_description'];

    public function getFullDescriptionAttribute()
    {
        return "{$this->brand} {$this->dose_per_tablet} x {$this->quantity_of_tablets}";
    }
}

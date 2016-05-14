class Api::V1::MedicinesController < ApplicationController

  def index
    @medicines = Medicine.all
  end

end

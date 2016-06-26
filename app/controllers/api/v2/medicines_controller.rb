class Api::V2::MedicinesController < ApplicationController

  def index
    @medicines = Medicine.where(visible: true)
  end

end

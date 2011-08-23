class ClassesController < ApplicationController
  def index
    @classes
    responds_to(:html)
  end
end

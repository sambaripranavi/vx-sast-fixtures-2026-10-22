# FX-BEGIN RB-C01
class CleanController < ApplicationController
  def index
    @total = [1, 2, 3].sum
    render plain: "Total: #{@total}"
  end
end
# FX-END RB-C01

class DelayedSimulation
  attr_accessor :time
  def initialize(time)
    self.time = time
  end

  def perform
   VehicleJourney.simulate_all(time)
  end
end


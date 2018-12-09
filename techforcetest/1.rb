class CropRatio

  def initialize
    @crops = {}
  end

  def add(name, crop_weight)
    @crops[name] ||= 0
    @crops[name] += crop_weight
  end

  def proportion(name)
    return @crops[name] / @crops.values.sum
  end

end

crop_ratio = CropRatio.new
crop_ratio.add('Wheat', 4);
crop_ratio.add('Wheat', 5);
crop_ratio.add('Rice', 1);

puts crop_ratio.proportion("Wheat")

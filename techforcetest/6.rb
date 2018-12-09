require 'date'

module DateTransform
  RULES = [
    /(?<year>\d{4})\/(?<month>\d{2})\/(?<day>\d{2})/,
    /(?<day>\d{2})\/(?<month>\d{2})\/(?<year>\d{4})/,
    /(?<moth>\d{2})-(?<day>\d{2})-(?<year>\d{4})/
  ]

  def self.change_date_format(dates)
    dates.map do |date|
      self.process_date(date)
    end.compact
  end

  def self.process_date(date)
    date_hash = match(date)
    if date_hash
      self.format_date(date_hash)
    else
      nil
    end
  end

  def self.match(value)
    RULES.each do |rule|
      result = value.match(rule)
      return result unless result.nil?
    end
    nil
  end

  def self.format_date(match)
    match[:year] + match[:month] + match[:day]
  end
end

p DateTransform.change_date_format(["2010/03/30", "15/12/2016", "11-15-2012", "20130720"])

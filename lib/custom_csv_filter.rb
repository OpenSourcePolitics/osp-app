class CustomCSVFilter
  def initialize(options)
    @options = options
  end

  def match(row)
    Rails.logger.debug row.class
    @result = true
    @options[:csv_filter].each_with_index do |key,value|
      if row.include?(key)
        Rails.logger.info "CSV filter for #{key} = #{value} with #{row[key]}"
        @result &&= ( row[key] == value )
      end
    end
    if @options[:validation].present? && @options[:validation].is_a?(Date)
      Rails.logger.info "CSV filter validation date #{@options[:validation]} with #{row[@options[:validation]]}"
      @result &&= ( row[@options[:validation]] <= Time.now )
    end
    @result
  end
end

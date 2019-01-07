# no guarantee for memory usage efficiency
# no garantee for computation efficiency
# no garentee for no-bug :D
class SimpleCombiner
  def self.permutate(the_list, number, current_list = [])
    return current_list if number == 0

    result = the_list.map do |element|
      _current_list = Marshal.load(Marshal.dump(current_list))
      _current_list << element
      permutate(the_list, number - 1, _current_list.freeze)
    end

    return result[0][0].is_a?(Array) ? result.inject([]){|arr, ele| arr + ele} : result
  end


  def self.combine(the_list, number)
      return [] if number == 0 || the_list.empty?

    this_results = []
    while element = the_list.delete_at(0)
      results = []

      number.downto(0).each do |num|
        combine_results = [[nil]]
        combine_results = combine(Marshal.load(Marshal.dump(the_list)), number - num) + combine_results

        result = []
        combine_results.each do |combine_result|
          result = ([element] * num + combine_result).compact

          if result.size < number
            break
          else
            results << result
          end
        end
      end

      if this_results.last != results.last
        this_results += results
      else
      end
    end

    return this_results
  end
end

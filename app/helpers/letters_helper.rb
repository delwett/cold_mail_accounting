module LettersHelper
  def available_states
    @letter.aasm.events(permitted: true).map(&:name) << @letter.letter_status
  end

  def available_event
    @letter.aasm.events(:permitted => true).map(&:name).any?
  end

  def array_of_states_with_translate
    @res = Array.new
    @res << ['Any', nil]
    Letter.aasm.states.map(&:name).each do |item|
      @res << [t(item), item]
    end
    @res
  end
end

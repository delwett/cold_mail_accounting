module LettersHelper
  def available_states
    @letter.aasm.events(permitted: true).map(&:name) << @letter.letter_status
  end
end

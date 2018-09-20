module LettersHelper
  def available_states
    @letter.aasm.events.map(&:name)
  end
end

module LettersHelper
  def available_states
    @letter.aasm.events(permitted: true).map(&:name) << @letter.letter_status
  end

  def available_event
    @letter.aasm.events(:permitted => true).map(&:name).any?
  end

  def array_of_states_with_translate
  [[t(:any), '']] + Letter.aasm.states.map(&:name).map { |item| [t(item), item]}
  end
end

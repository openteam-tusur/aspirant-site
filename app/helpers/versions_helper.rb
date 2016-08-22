module VersionsHelper
  def set_council_numbers(item)
    council_numbers = []
    current_number = DissertationCouncil.find(item.last.first).number rescue nil
    changed_number = DissertationCouncil.find(item.last.last).number rescue nil
    council_numbers << current_number
    council_numbers << changed_number
    council_numbers
  end

  def set_aasm_states(item)
    states = []
    states << I18n.t("paper_trail.aasm_state.#{item.last.first}") if item.last.first
    states << I18n.t("paper_trail.aasm_state.#{item.last.last}") if item.last.last
    states
  end
end

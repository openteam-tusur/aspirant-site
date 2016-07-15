class RemoveColumnMentorIdAndApplicantIdFromAdvert < ActiveRecord::Migration
  def change
    remove_column :adverts, :mentor_id
    remove_column :adverts, :applicant_id
  end
end

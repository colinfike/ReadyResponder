require 'rails_helper'

RSpec.describe "Tasks" do
  before(:each) { sign_in_as('Editor') }

  get_nested_editor_views('event', 'task', ['title', 'description', 'street'])

  let(:task_title) { "A Fantastic Task" }
  describe "creates" do
    it "tasks" do
      @event = create(:event)
      visit new_event_task_path(@event)
      fill_in "Title", with: task_title
      fill_in "task_start_time", with: format_datetime_value(2.days.from_now)
      fill_in "task_end_time", with: format_datetime_value(3.days.from_now)
      click_on 'Create Task'
      expect(page).to have_content "Task was successfully created."
      visit event_path(@event)
      expect(page).to have_content task_title
      visit tasks_path
      expect(page).to have_content task_title
    end
  end
end

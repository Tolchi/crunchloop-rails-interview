require 'rails_helper'

RSpec.describe CompleteAllJob, type: :job do
  include ActiveJob::TestHelper

  let!(:todo_list) { create(:todo_list) }
  let!(:todos) { create_list(:todo, 3, todo_list: todo_list) }
  let(:todos_ids) { todos.pluck(:id) }

  subject(:job) { described_class.perform_later(todos_ids) }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'is in default queue' do
    expect(CompleteAllJob.new.queue_name).to eq('complete_all')
  end

  it 'updates all todos as completed with perform_now' do
    described_class.perform_now(todos_ids)
    todos.each do |t|
      t.reload
      expect(t.completed).to eq(true)
    end
  end

  after do

    clear_enqueued_jobs
    clear_performed_jobs
  end
end

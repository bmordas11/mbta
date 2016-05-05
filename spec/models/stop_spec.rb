require 'rails_helper'

RSpec.describe Stop, type: :model do
  it { should have_valid(:name).when('Quisolo', 'The Volterra') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:number_trains).when(3, 235) }

  it 'has unique name constraint' do
    Stop.create(
      name: 'Stoppy stop',
      number_trains: 1
    )
    stop_2 = Stop.new(
      name: 'Stoppy stop',
      number_trains: 21
    )

    expect(stop_2).to_not be_valid
    expect(stop_2.errors).to_not be_blank
  end
end

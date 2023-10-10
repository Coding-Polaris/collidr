RSpec.shared_examples_for "SaveableBroadcaster" do |model|
  it "broadcasts validation failure" do
    model.valid?

    expect { model.save }.to broadcast(:save_failure, model)
  end

  it "broadcasts save failure" do
    model.save

    expect { model.save }.to broadcast(:save_failure, model)
  end

  it "broadcasts save success" do
    model.save

    expect { model.save }.to broadcast(:save_success, model)
  end
end
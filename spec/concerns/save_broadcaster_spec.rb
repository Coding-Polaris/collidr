RSpec.shared_examples_for "SaveBroadcaster" do |model|
  let(:model_instance) { build(model) }
  let(:model_instance_fail) { build(model, :invalid) }

  it "broadcasts successful creation" do
    expect { model_instance.save }.to broadcast(:created, model_instance)
  end

  it "broadcasts successful update" do
    model_instance.save
    expect { model_instance.save }.to broadcast(:updated, model_instance)
  end

  it "broadcasts save failure" do
    expect { model_instance_fail.save }.to broadcast(:failed, model_instance_fail)
  end
end
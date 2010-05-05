require "osx/foundation"
OSX.require_framework('IOKit')
require "osx/cocoa"
require "uvccameracontrol"

class OrbitControl
  attr_accessor :location

  def initialize(vendor_id = 0x046d,product_id = 0x0994)
    @vendor = vendor_id
    @product = product_id
    @camera_control = nil
  end

  def cmd(cmd,val=nil)
    case cmd
    when /reset/
      reset
    when /pan/
      pan(val.to_i)
    when /tilt/
      tilt(val.to_i)
    when /list_devices/
      list_devices
    end
  end

  def list_devices
    tmp =  OSX::UVCCameraControl.alloc.initWithLocationID(0)
    tmp.release
  end
  
  def close 
    # @camera_control.release
    @camera_control = nil
  end

  def reset
    open_control unless @camera_control
    tilt(10)
    sleep 10
    @camera_control.resetTiltPan(true)
  end

  def pan(val)
    open_control unless @camera_control
    @camera_control.setPanTilt_withPan_withTilt(false,
                               val,0)
  end

  def tilt(val)
    open_control unless @camera_control
    @camera_control.setPanTilt_withPan_withTilt(false,
                               0,val)
  end

  private 
  def open_control
    if @location
      open_control_location
    else
      open_control_vendor
    end
  end

  def open_control_location
    @camera_control = OSX::UVCCameraControl.alloc.initWithLocationID(@location)
  end

  def open_control_vendor
  #  @camera_control = OSX::UVCCameraControl.alloc.initWithVendorID_productID(
  #    @vendor.to_i,0x0994)
    @camera_control = OSX::UVCCameraControl.alloc.initWithVendorID_productID(
      @vendor, @product)
  end

  def close_control
    @camera_control.release
  end

end


if __FILE__ == $0
  oc = OrbitControl.new
  if ENV["LXU_LOCATION"]
    oc.location = ENV["LXU_LOCATION"].hex 
  end
  oc.cmd(ARGV[0],ARGV[1])
end

import Cocoa

class MVMainView: NSView {
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    
    let nc = NotificationCenter.default
    nc.addObserver(self, selector: #selector(windowFocusChanged), name: NSNotification.Name.NSWindowDidBecomeKey, object: nil)
    nc.addObserver(self, selector: #selector(windowFocusChanged), name: NSNotification.Name.NSWindowDidResignKey, object: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    let nc = NotificationCenter.default
    nc.removeObserver(self)
  }
  
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    
    let windowHasFocus = self.window?.isKeyWindow ?? false
    var topColor = NSColor(srgbRed: 0.333, green: 0.333, blue: 0.333, alpha: 1.0)
    var bottomColor = NSColor(srgbRed: 0, green: 0, blue: 0, alpha: 1.0)
    if !windowHasFocus {
      topColor = NSColor(srgbRed: 0.300, green: 0.300, blue: 0.300, alpha: 1.0)
      bottomColor = NSColor(srgbRed: 0, green: 0, blue: 0, alpha: 1.0)
    }
    
    let gradient = NSGradient(colors: [topColor, bottomColor])
    let radius: CGFloat = 4.53
    let path = NSBezierPath(roundedRect: self.bounds, xRadius: radius, yRadius: radius)
    gradient?.draw(in: path, angle: -90)
  }
  
  func windowFocusChanged(_ notification: Notification) {
    self.needsDisplay = true
  }
  
}

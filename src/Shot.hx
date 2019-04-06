package;

import h2d.Object;
import h2d.Bitmap;
import h2d.Tile;

class Shot extends Bitmap{

  public var friendly(default, null):Bool;
  private var xSpeed: Float;
  private var ySpeed: Float;

  public function new(parent: Object, friendly: Bool, x: Float, y: Float) {
    super(friendly ? Tile.fromColor(0x00FF00, 10, 10) : Tile.fromColor(0x00FFFF, 10, 10), parent);
    this.friendly = friendly;
    x = 20 + Math.random() * (parent.getSize().width - 40);
  }

  public function collidesWith(other: Bitmap): Bool {
    var collider = getBounds();
    var otherCollider = other.getBounds();
    return collider.intersects(otherCollider);
  }

  public function update(dt: Float) {
    if (friendly) {
      y -= dt * 400;
    } else {
      y += dt * 400;
    }
  }
}
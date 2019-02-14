package;

import h2d.Scene;
import h2d.Bitmap;
import h2d.Tile;

class Enemy extends Bitmap{

  var ammoCooldown: Float = 0;
  var ammo: Array<Shot>;

  public function new(parent: Scene, ammo: Array<Shot>, ?x: Float = 0, ?y: Float = 0) {
    super(Tile.fromColor(0x0000FF, 40, 40), parent);
    this.x = x;
    this.y = y;
    this.ammo = ammo;
  }

  public function collidesWith(other: Bitmap) {
    var collider = getBounds();
    var otherCollider = other.getBounds();
    return collider.intersects(otherCollider);
  }

  public function update(dt: Float) {
    y += dt * 100;

    if (ammoCooldown >= 0) {
      ammoCooldown -= dt;
    }

    if (ammoCooldown < 0) {
      var shot = new Shot(parent, false, x, y);
      shot.x = x + getSize().width / 2 - shot.getSize().width / 2;
      shot.y = y;
      ammo.push(shot);
      ammoCooldown = 0.5;
    }
  }
}
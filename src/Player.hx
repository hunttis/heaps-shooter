package;

import hxd.Key;
import h2d.Scene;
import h2d.Bitmap;
import h2d.Tile;

class Player extends Bitmap{

  var ammoCooldown: Float = 0;
  var ammo: Array<Shot>;

  public function new(parent: Scene, ammo: Array<Shot>) {
    super(Tile.fromColor(0xFF0000, 30, 30), parent);
    x = 200;
    y = 400;
    this.ammo = ammo;
  }

  public function update(dt: Float) {

    if (ammoCooldown >= 0) {
      ammoCooldown -= dt;
    }

    if (Key.isDown(Key.UP)) {
      y -= dt * 200;
    } else if (Key.isDown(Key.DOWN)) {
      y += dt * 200;
    }

    if (Key.isDown(Key.LEFT)) {
      x -= dt * 200;
    } else if (Key.isDown(Key.RIGHT)) {
      x += dt * 200;
    }

    if (Key.isDown(Key.SPACE) && ammoCooldown < 0) {
      var shot = new Shot(parent, true, x, y);
      shot.x = x + getSize().width / 2 - shot.getSize().width / 2;
      shot.y = y;
      ammo.push(shot);
      ammoCooldown = 0.5;
    }    
  }

  public function collidesWith(other: Bitmap) {
    var collider = getBounds();
    var otherCollider = other.getBounds();
    return collider.intersects(otherCollider);
  }
}
package;

import hxd.Key;
import h2d.Scene;
import h2d.Bitmap;
import h2d.Tile;

class Player extends Bitmap{

  var ammoCooldown: Float = 0;
  var ammo: Array<Shot>;

  var xSpeed: Float;
  var ySpeed: Float;
  var xAccelerationRate: Float = 100;
  var yAccelerationRate: Float = 100;
  var xSpeedMax: Float = 300;
  var ySpeedMax: Float = 200;

  public function new(parent: Scene, ammo: Array<Shot>) {
    super(Tile.fromColor(0xFF0000, 40, 20), parent);
    x = 200;
    y = 400;
    this.ammo = ammo;
  }

  public function update(dt: Float) {

    if (ammoCooldown >= 0) {
      ammoCooldown -= dt;
    }

    if (Key.isDown(Key.UP)) {
      ySpeed = Math.max(ySpeed - (yAccelerationRate), -ySpeedMax);
    } else if (Key.isDown(Key.DOWN)) {
      ySpeed = Math.min(ySpeed + (yAccelerationRate), ySpeedMax);
    } else {
      ySpeed = ySpeed * 0.8;
    }

    if (Key.isDown(Key.LEFT)) {
      xSpeed = Math.max(xSpeed - (xAccelerationRate), -xSpeedMax);
    } else if (Key.isDown(Key.RIGHT)) {
      xSpeed = Math.min(xSpeed + (xAccelerationRate), xSpeedMax);
    } else {
      xSpeed = xSpeed * 0.8;
    }

    if (Key.isDown(Key.SPACE) && ammoCooldown < 0) {
      var shot = new Shot(parent, true, x, y);
      shot.x = x + getSize().width / 2 - shot.getSize().width / 2;
      shot.y = y;
      ammo.push(shot);
      ammoCooldown = 0.5;
    }

    y += ySpeed * dt;
    x += xSpeed * dt;
  }

  public function collidesWith(other: Bitmap): Bool {
    var collider = getBounds();
    var otherCollider = other.getBounds();
    return collider.intersects(otherCollider);
  }
}
package;

import h2d.Scene;
import h2d.col.RoundRect;
import h2d.col.Bounds;
import h2d.Tile;
import h2d.Bitmap;
import hxd.Key;

class Main extends hxd.App {

  var player: Player;
  var ammo: Array<Shot> = [];
  var enemies: Array<Enemy> = [];

  var enemyCooldown: Float = 2;

  override function init() {
    player = new Player(s2d, ammo);
  }

  override function update(dt: Float) {

    player.update(dt);

    if (Key.isDown(Key.ESCAPE)) {
      trace('QUIT');
      #if !js
      Sys.exit(0);
      #end
    }

    if (enemyCooldown >= 0) {
      enemyCooldown -= dt;
    }

    if (enemyCooldown < 0) {
      var xLoc = 20 + Math.random() * (s2d.width - 40);
      var enemy = new Enemy(s2d, ammo, xLoc);

      enemies.push(enemy);
      enemyCooldown = 1;
    }

    for(shot in ammo) {
      shot.update(dt);
    }

    for (enemy in enemies) {
      enemy.update(dt);
    }

    checkShotCollisions();
  }

  private function checkShotCollisions() {
    for (shot in ammo) {
      var destroyed = false;

      if (shot.friendly) {
        for (enemy in enemies) {
          if (enemy.collidesWith(shot)) {
            enemy.remove();
            enemies.remove(enemy);
            destroyed = true;
          }
        }
      } else if (!shot.friendly) {
        if (player.collidesWith(shot)) {
          destroyed = true;
        }
      }

      if (shot.y < 0 || shot.y > 1600) {
        destroyed = true;
      }

      if (destroyed) {
        shot.remove();
        ammo.remove(shot);
      }
    }
  }
    
  static function main() {
    new Main();
  }
}
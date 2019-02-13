package;

import h2d.col.RoundRect;
import h2d.col.Bounds;
import h2d.Tile;
import h2d.Bitmap;
import hxd.Key;

class Main extends hxd.App {

  var ammoTemplate: Tile;
  var enemyTemplate: Tile;

  var player: Bitmap;
  var ammo: Array<Bitmap> = [];
  var enemies: Array<Bitmap> = [];

  var ammoCooldown: Float = 0;
  var enemyCooldown: Float = 2;

  override function init() {
    var playerTemplate = h2d.Tile.fromColor(0xFF0000, 30, 30);
    ammoTemplate = Tile.fromColor(0x00FF00, 10, 10);  
    enemyTemplate = h2d.Tile.fromColor(0x0000FF, 40, 40);

    player = new Bitmap(playerTemplate, s2d);
    player.x = 200;
    player.y = 400;
  }

  override function update(dt: Float) {
    if (Key.isDown(Key.UP)) {
      player.y -= dt * 200;
    } else if (Key.isDown(Key.DOWN)) {
      player.y += dt * 200;
    }
    if (Key.isDown(Key.LEFT)) {
      player.x -= dt * 200;
    } else if (Key.isDown(Key.RIGHT)) {
      player.x += dt * 200;
    }

    if (Key.isDown(Key.ESCAPE)) {
      trace('QUIT');
      #if !js
      Sys.exit(0);
      #end
    }

    if (ammoCooldown >= 0) {
      ammoCooldown -= dt;
    }

    if (enemyCooldown >= 0) {
      enemyCooldown -= dt;
    }

    if (enemyCooldown < 0) {
      var enemy = new Bitmap(enemyTemplate, s2d);
      enemy.x = 20 + Math.random() * (s2d.width - 40);
      enemies.push(enemy);
      enemyCooldown = 1;
    }

    if (Key.isDown(Key.SPACE) && ammoCooldown < 0) {
      var shot = new Bitmap(ammoTemplate, s2d);
      shot.x = player.x + player.getSize().width / 2 - shot.getSize().width / 2;
      shot.y = player.y;
      ammo.push(shot);
      ammoCooldown = 0.5;
    }

    for(shot in ammo) {
      shot.y -= dt * 400;

      var destroyed = false;

      var shotCollider = shot.getBounds();
      
      for (enemy in enemies) {
        var enemyCollider = enemy.getBounds();
        if (shotCollider.intersects(enemyCollider)) {
          enemy.remove();
          enemies.remove(enemy);
          destroyed = true;
        }
      }

      if (shot.y < 0) {
        destroyed = true;
      }

      if (destroyed) {
        shot.remove();
        ammo.remove(shot);
      }
    }

    for (enemy in enemies) {
      enemy.y += dt * 100;
    }
  }
    
  static function main() {
      new Main();
  }
}
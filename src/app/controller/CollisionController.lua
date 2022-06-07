CollisionController = CollisionController or {}

CollisionController.enemyArray = {}
CollisionController.bulletArray = {}
CollisionController.role = nil

function CollisionController.addEnemy(enemy)
    table.insert(CollisionController.enemyArray, enemy)
end

function CollisionController.addBullet(bullet)
    table.insert(CollisionController.bulletArray, bullet)
end

function CollisionController.setRole(target)
    CollisionController.role = target
end

function CollisionController.removeEnemy(enemy)
    table.removebyvalue(CollisionController.enemyArray, enemy, false)
end

function CollisionController.removeBullet(bullet)
    table.removebyvalue(CollisionController.bulletArray, bullet, false)
end

return CollisionController

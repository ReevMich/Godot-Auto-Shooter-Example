using Godot;
using System;

namespace Game.Component
{
    public partial class BulletComponent : Area2D
    {
        [Export]
        public float DamageAmount;

        public override void _Ready()
        {
            Connect(SignalName.AreaEntered, new Callable(this, nameof(OnAreaEntered)));
        }

        private void OnAreaEntered(Area2D area)
        {
            var hurtbox = area as HurtboxComponent;
            hurtbox?.HandleBulletCollision(this);
        }

    }

    public partial class BulletCollisionEvent
    {
        public float DamageAmount;
    }
}
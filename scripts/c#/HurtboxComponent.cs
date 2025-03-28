using Godot;
using System;
using System.Runtime.CompilerServices;

namespace Game.Component
{
    [Tool]
    public partial class HurtboxComponent : Area2D
    {
        [Signal]
        public delegate void HitByBulletEventHandler(HitByBulletEvent hitByBulletEvent);

        [Export]
        private HealthComponent healthComponent;

        public override void _Ready()
        {
            Connect(SignalName.AreaEntered, new Callable(this, nameof(OnAreaEntered)));
        }

        public bool CanAcceptBulletCollision()
        {
            return healthComponent?.HasHealthRemaining ?? true;
        }


        public void HandleBulletCollision(BulletComponent bullet)
        {
            // We get the damage amount from the bullet component
            var damageAmount = bullet.DamageAmount;

            // We take the damage amount from the bullet and apply it to the health component
            healthComponent?.Damage(damageAmount);

            // We emit the hit by bullet event
            var hitByBulletEvent = new HitByBulletEvent { DamageAmount = damageAmount };
            EmitSignal(SignalName.HitByBullet, hitByBulletEvent);
        }

        private void OnAreaEntered(Area2D area)
        {

        }
    }

    public partial class HitByBulletEvent : RefCounted
    {
        public float DamageAmount;
    }
}

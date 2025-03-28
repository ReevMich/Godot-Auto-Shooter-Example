using Godot;
using System;

namespace Game.Component
{
    [Tool]
    public partial class HealthComponent : Node
    {

        [Signal]
        public delegate void HealthChangedEventHandler(HealthUpdate healthUpdate);

        [Signal]
        public delegate void DeathEventHandler();

        [Export]
        public float MaxHealth
        {
            get => maxHealth;
            private set
            {
                maxHealth = value;
                if (CurrentHealth > maxHealth)
                {
                    CurrentHealth = maxHealth;
                }
            }
        }

        public bool HasHealthRemaining => !Mathf.IsEqualApprox(CurrentHealth, 0f);
        public float CurrentHealthPercentage => MaxHealth > 0f ? CurrentHealth / MaxHealth : 0f;

        public float CurrentHealth
        {
            get => currentHealth;
            private set
            {
                currentHealth = Mathf.Clamp(value, 0, maxHealth);
                // We can emit a signal that health has changed
                EmitSignal(SignalName.HealthChanged, new HealthUpdate
                {
                    CurrentHealth = currentHealth,
                    MaxHealth = maxHealth,
                    HealthPercentage = currentHealth / maxHealth,
                });

                // We can also add dealth detection and signal that here
                if (!HasHealthRemaining && !hasDied)
                {
                    hasDied = true;
                    EmitSignal(SignalName.Death);
                }
            }

        }

        public bool IsDamaged => CurrentHealth < MaxHealth;
        private bool hasDied;
        private float maxHealth = 5f;
        private float currentHealth = 5f;

        public override void _Ready()
        {
            CallDeferred(nameof(InitializeHealth));
        }

        private void InitializeHealth()
        {
            CurrentHealth = MaxHealth;
        }

        public void Damage(float amount)
        {
            CurrentHealth -= amount;
        }
    }

    public partial class HealthUpdate : RefCounted
    {
        public float CurrentHealth;
        public float MaxHealth;
        public float HealthPercentage;
    }
}


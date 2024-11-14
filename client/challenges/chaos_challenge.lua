using System;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.UI;
using static CitizenFX.Core.Native.API;
using WorldEventsM.Shared.Enum;

namespace WorldEventsM.Client.Events
{
    public class ChaosChallenge : IWorldEvent
    {
        public ChaosChallenge(int id, string name, double countdownTime, double seconds) 
            : base(id, name, countdownTime, seconds, false, "AMCH_CHAOS", PlayerStats.NPCCarDamage, "$", PlayerStatType.Float)
        {
            Client.GetInstance().RegisterTickHandler(OnTick);
        }

        public override void OnEventActivated()
        {
            FirstStartedTick = true;
            base.OnEventActivated();
        }

        private async Task OnTick()
        {
            try
            {
                if (!IsActive) return;

                if (!IsStarted)
                {
                    Screen.ShowSubtitle($"Cause chaos and damage NPC vehicles in the {Name} Challenge!", 50);
                }
                else
                {
                    float damageDealt = GetEntityHealth(Game.PlayerPed.CurrentVehicle.Handle);
                    IncrementPlayerStat(PlayerStats.NPCCarDamage, damageDealt);
                    Screen.ShowSubtitle(GetLabelText("AMCH_CHAOS"), 50);
                }
            }
            catch (Exception ex)
            {
                Logger.Exception(ex);
            }

            await Task.FromResult(0);
        }
    }
}

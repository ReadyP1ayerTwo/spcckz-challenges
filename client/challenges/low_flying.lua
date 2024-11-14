using System;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.UI;
using static CitizenFX.Core.Native.API;
using WorldEventsM.Shared.Enum;

namespace WorldEventsM.Client.Events
{
    public class LowFlying : IWorldEvent
    {
        public LowFlying(int id, string name, double countdownTime, double seconds) 
            : base(id, name, countdownTime, seconds, false, "AMCH_LOWFLY", PlayerStats.LowFlyingDistance, "m", PlayerStatType.Float)
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
                    Screen.ShowSubtitle($"Find an aircraft and prepare for the {Name} Challenge. Fly low to the ground!", 50);
                }
                else
                {
                    float altitude = GetEntityHeightAboveGround(Game.PlayerPed.CurrentVehicle.Handle);
                    if (altitude < 50f)
                    {
                        IncrementPlayerStat(PlayerStats.LowFlyingDistance, 1.0f);
                        Screen.ShowSubtitle(GetLabelText("AMCH_LOWFLY"), 50);
                    }
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

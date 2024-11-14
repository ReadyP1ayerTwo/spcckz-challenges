using System;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.UI;
using static CitizenFX.Core.Native.API;
using WorldEventsM.Shared.Enum;

namespace WorldEventsM.Client.Events
{
    public class InvertedFlying : IWorldEvent
    {
        public InvertedFlying(int id, string name, double countdownTime, double seconds) 
            : base(id, name, countdownTime, seconds, false, "AMCH_FLIP_0", PlayerStats.InvertedFlyingDistance, "m", PlayerStatType.Float)
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
                    Screen.ShowSubtitle($"Find an aircraft and prepare for the {Name} Challenge. Fly inverted!", 50);
                }
                else
                {
                    float altitude = GetEntityHeightAboveGround(Game.PlayerPed.CurrentVehicle.Handle);
                    bool isUpsideDown = GetEntityRoll(Game.PlayerPed.CurrentVehicle.Handle) > 90f || GetEntityRoll(Game.PlayerPed.CurrentVehicle.Handle) < -90f;

                    if (altitude < 100f && isUpsideDown)
                    {
                        IncrementPlayerStat(PlayerStats.InvertedFlyingDistance, 1.0f);
                        Screen.ShowSubtitle(GetLabelText("AMCH_FLIP_0"), 50);
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

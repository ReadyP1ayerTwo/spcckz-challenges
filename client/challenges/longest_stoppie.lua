using System;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.UI;
using static CitizenFX.Core.Native.API;
using WorldEventsM.Shared.Enum;

namespace WorldEventsM.Client.Events
{
    public class LongestStoppie : IWorldEvent
    {
        public LongestStoppie(int id, string name, double countdownTime, double seconds) 
            : base(id, name, countdownTime, seconds, false, "AMCH_STOPPIE", PlayerStats.LongestStoppieDistance, "m", PlayerStatType.Float)
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
                    Screen.ShowSubtitle($"Find a motorcycle and prepare for the {Name} Challenge. Perform the longest stoppie!", 50);
                }
                else
                {
                    bool isPerformingStoppie = GetEntityPitch(Game.PlayerPed.CurrentVehicle.Handle) < -10f;
                    if (isPerformingStoppie)
                    {
                        IncrementPlayerStat(PlayerStats.LongestStoppieDistance, 1.0f);
                        Screen.ShowSubtitle(GetLabelText("AMCH_STOPPIE"), 50);
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

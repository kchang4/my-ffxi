/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "lua_action.h"

#include "action/action.h"

CLuaAction::CLuaAction(action_t* Action)
: m_PLuaAction(Action)
{
    if (Action == nullptr)
    {
        ShowError("CLuaAction created with nullptr instead of valid action_t*!");
    }
}

void CLuaAction::ID(uint32 actionTargetID, uint32 newActionTargetID)
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.actorId = newActionTargetID;
            return;
        }
    }
}

// Get the first (primary) target's long ID, if available.
uint32 CLuaAction::getPrimaryTargetID()
{
    if (!m_PLuaAction->targets.empty())
    {
        return m_PLuaAction->targets[0].actorId;
    }

    return 0;
}

void CLuaAction::setRecast(uint16 recast)
{
    m_PLuaAction->recast = std::chrono::seconds(recast);
}

uint16 CLuaAction::getRecast()
{
    return static_cast<uint16>(timer::count_seconds(m_PLuaAction->recast));
}

void CLuaAction::actionID(uint16 actionid)
{
    m_PLuaAction->actionid = actionid;
}

uint16 CLuaAction::getParam(uint32 actionTargetID)
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            return actionTarget.results[0].param;
        }
    }

    return 0;
}

void CLuaAction::param(uint32 actionTargetID, int32 param)
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].param = param;
            return;
        }
    }
}

void CLuaAction::messageID(uint32 actionTargetID, MSGBASIC_ID messageID)
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].messageID = messageID;
            return;
        }
    }
}

std::optional<uint16> CLuaAction::getMsg(uint32 actionTargetID) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            return actionTarget.results[0].messageID;
        }
    }

    return std::nullopt;
}

auto CLuaAction::getAnimation(uint32 actionTargetID) -> std::optional<ActionAnimation>
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            return actionTarget.results[0].animation;
        }
    }

    return std::nullopt;
}

void CLuaAction::setAnimation(uint32 actionTargetID, ActionAnimation animation)
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].animation = animation;
            return;
        }
    }
}

auto CLuaAction::getCategory() const -> ActionCategory
{
    return m_PLuaAction->actiontype;
}

void CLuaAction::setCategory(uint8 category)
{
    m_PLuaAction->actiontype = static_cast<ActionCategory>(category);
}

void CLuaAction::resolution(const uint32 actionTargetID, const ActionResolution resolution) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].resolution = resolution;
            return;
        }
    }
}

void CLuaAction::info(const uint32 actionTargetID, const ActionInfo info) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].info |= info;
            return;
        }
    }
}

void CLuaAction::hitDistortion(const uint32 actionTargetID, const HitDistortion distortion) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].hitDistortion = distortion;
            return;
        }
    }
}

void CLuaAction::knockback(const uint32 actionTargetID, const Knockback knockback) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].knockback = knockback;
            return;
        }
    }
}

void CLuaAction::damage(CLuaBaseEntity* PLuaTarget, const int32 damage) const
{
    if (auto* PTarget = dynamic_cast<CBattleEntity*>(PLuaTarget->GetBaseEntity()))
    {
        const uint32 actionTargetID = PTarget->id;
        for (auto&& actionTarget : m_PLuaAction->targets)
        {
            if (actionTarget.actorId == actionTargetID)
            {
                actionTarget.results[0].param = damage;
                return;
            }
        }
    }
}

void CLuaAction::physicalDamage(CLuaBaseEntity* PLuaTarget, const int32 damage, const bool isCritical) const
{
    if (auto* PTarget = dynamic_cast<CBattleEntity*>(PLuaTarget->GetBaseEntity()))
    {
        const uint32 actionTargetID = PTarget->id;
        for (auto&& actionTarget : m_PLuaAction->targets)
        {
            if (actionTarget.actorId == actionTargetID)
            {
                actionTarget.results[0].recordDamage(attack_outcome_t{
                    .atkType    = ATTACK_TYPE::PHYSICAL,
                    .damage     = damage,
                    .target     = PTarget,
                    .isCritical = isCritical,
                });

                return;
            }
        }
    }
}

void CLuaAction::modifier(uint32 actionTargetID, uint8 modifier)
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].modifier = static_cast<ActionModifier>(modifier);
            return;
        }
    }
}

void CLuaAction::additionalEffect(uint32 actionTargetID, uint16 additionalEffect)
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].additionalEffect = static_cast<SUBEFFECT>(additionalEffect);
            return;
        }
    }
}

void CLuaAction::addEffectParam(uint32 actionTargetID, int32 addEffectParam)
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].addEffectParam = addEffectParam;
            return;
        }
    }
}

void CLuaAction::addEffectMessage(uint32 actionTargetID, MSGBASIC_ID addEffectMessage)
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            actionTarget.results[0].addEffectMessage = addEffectMessage;
            return;
        }
    }
}

bool CLuaAction::addAdditionalTarget(uint32 actionTargetID)
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetID)
        {
            return false;
        }
    }

    auto& newAction = m_PLuaAction->addTarget(actionTargetID);
    newAction.addResult();

    return true;
}

//==========================================================//

void CLuaAction::Register()
{
    SOL_USERTYPE("CAction", CLuaAction);
    SOL_REGISTER("ID", CLuaAction::ID);
    SOL_REGISTER("getPrimaryTargetID", CLuaAction::getPrimaryTargetID);
    SOL_REGISTER("getRecast", CLuaAction::getRecast);
    SOL_REGISTER("setRecast", CLuaAction::setRecast);
    SOL_REGISTER("actionID", CLuaAction::actionID);
    SOL_REGISTER("getParam", CLuaAction::getParam);
    SOL_REGISTER("param", CLuaAction::param);
    SOL_REGISTER("messageID", CLuaAction::messageID);
    SOL_REGISTER("getMsg", CLuaAction::getMsg);
    SOL_REGISTER("getAnimation", CLuaAction::getAnimation);
    SOL_REGISTER("setAnimation", CLuaAction::setAnimation);
    SOL_REGISTER("getCategory", CLuaAction::getCategory);
    SOL_REGISTER("setCategory", CLuaAction::setCategory);
    SOL_REGISTER("resolution", CLuaAction::resolution);
    SOL_REGISTER("info", CLuaAction::info);
    SOL_REGISTER("hitDistortion", CLuaAction::hitDistortion);
    SOL_REGISTER("knockback", CLuaAction::knockback);
    SOL_REGISTER("damage", CLuaAction::damage);
    SOL_REGISTER("physicalDamage", CLuaAction::physicalDamage);
    SOL_REGISTER("modifier", CLuaAction::modifier);
    SOL_REGISTER("additionalEffect", CLuaAction::additionalEffect);
    SOL_REGISTER("addEffectParam", CLuaAction::addEffectParam);
    SOL_REGISTER("addEffectMessage", CLuaAction::addEffectMessage);
    SOL_REGISTER("addAdditionalTarget", CLuaAction::addAdditionalTarget);
};

std::ostream& operator<<(std::ostream& os, const CLuaAction& action)
{
    std::string id = action.m_PLuaAction ? std::to_string(action.m_PLuaAction->actorId) : "nullptr";
    return os << "CLuaAction(" << id << ")";
}

//==========================================================//

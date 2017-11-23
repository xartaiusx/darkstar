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

  This file is part of DarkStar-server source code.

===========================================================================
*/
#include <string.h>

#include "baseentity.h"
#include "../map.h"
#include "../zone.h"
#include "../ai/ai_container.h"
#include "../instance.h"

CBaseEntity::CBaseEntity()
{
	m_TargID = 0;
	namevis = 1;

    PAI = nullptr;
	PBCNM = nullptr;
	PInstance = nullptr;

	speed    = 40 + map_config.speed_mod;
	speedsub = 40 + map_config.speed_mod;

	animationsub = 0;
	animation    = ANIMATION_NONE;

	status = STATUS_DISAPPEAR;
    updatemask = 0;

	memset(&loc,  0, sizeof(loc));
	memset(&look, 0, sizeof(look));
}

CBaseEntity::~CBaseEntity()
{
}

void CBaseEntity::Spawn()
{
    status = allegiance == ALLEGIANCE_MOB ? STATUS_MOB : STATUS_NORMAL;
    updatemask |= UPDATE_HP;
    ResetLocalVars();
    PAI->Reset();
    PAI->EventHandler.triggerListener("SPAWN", this);
}

void CBaseEntity::FadeOut()
{
    status = STATUS_DISAPPEAR;
    updatemask |= UPDATE_HP;
}

const std::int8_t* CBaseEntity::GetName()
{
	return (const std::int8_t*)name.c_str();
}

std::uint16_t CBaseEntity::getZone()
{
    return loc.zone != nullptr ? loc.zone->GetID() : loc.destination;
}

float CBaseEntity::GetXPos()
{
	return loc.p.x;
}

float CBaseEntity::GetYPos()
{
	return loc.p.y;
}

float CBaseEntity::GetZPos()
{
	return loc.p.z;
}

std::uint8_t CBaseEntity::GetRotPos()
{
	return loc.p.rotation;
}

void CBaseEntity::HideName(bool hide)
{
	if(hide)
	{
		// I totally guessed this number
		namevis |= FLAG_HIDE_NAME;
	}
	else
	{
		namevis &= ~FLAG_HIDE_NAME;
	}
    updatemask |= UPDATE_HP;
}

bool CBaseEntity::IsNameHidden()
{
	return namevis & FLAG_HIDE_NAME;
}

CBaseEntity* CBaseEntity::GetEntity(std::uint16_t targid, std::uint8_t filter)
{
	if (PInstance)
		return PInstance->GetEntity(targid, filter);
	else
		return loc.zone->GetEntity(targid, filter);
}

void CBaseEntity::ResetLocalVars()
{
    m_localVars.clear();
}

std::uint32_t CBaseEntity::GetLocalVar(const char* var)
{
    try
    {
        return m_localVars.at(var);
    }
    catch (std::out_of_range e)
    {
        return 0;
    }
}

void CBaseEntity::SetLocalVar(const char* var, std::uint32_t val)
{
    m_localVars[var] = val;
}

void CBaseEntity::SetModelId(std::uint16_t modelid)
{
    look.modelid = modelid;
}

std::uint16_t CBaseEntity::GetModelId()
{
    return look.modelid;
}
m = Map("applications", translate("Commotion Applications"), translate("Applications used in the Commotion bundle. Only applications manually created on this node can be modified."))

s = m:section(TypedSection, "application", translate("Applications"))
function s.filter(self, section)
	-- return not self.map:get(section, "signature")
	if luci.http.formvalue("app") then
		return self.map:get(section, "uuid") == luci.http.formvalue("app") and not self.map:get(section, "signature")
	end
	return not self.map:get(section, "signature")
end

name = s:option(Value, "name", "App Name"); name.optional=false; name.rmempty=false;
nick = s:option(Value, "nick", "App Nickname"); nick.optional=false; nick.rmempty=false;
ipaddr = s:option(Value, "ipaddr", "IP Address or URL"); ipaddr.optional=false; ipaddr.rmempty=false;
port = s:option(Value, "port", "Port"); port.optional=true; port.rmempty = true;
transport = s:option(ListValue, "transport", "Transport type"); transport.optional=false; transport.rmemtpy=true; transport:value("",""); transport:value("tcp","tcp"); transport:value("udp","udp");
icon = s:option(Value, "icon", "Icon"); icon.optional=false; icon.rmemtpy=false;
desc = s:option(TextValue, "description", "Description"); desc.optional=false; desc.rmempty=false;
type = s:option(DynamicList, "type", "Type"); type.default = misc;
ttl = s:option(Value, "ttl", "TTL"); ttl.optional=false; ttl.rmemtpy=true;
approved = s:option(ListValue, "approved", "Approved"); approved.optional=false; approved.rmempty=true; approved:value("",""); approved:value("1","approved"); approved:value("0","blacklisted");

return m

const $=s=>document.querySelector(s), $$=s=>[...document.querySelectorAll(s)];
const classes={
  warden:{name:"Demir Muhafız",desc:"Ön safta savaşır. Ağır zırh, yüksek dayanıklılık ve Kalkan Darbesi.",hp:34,mana:8,skill:"Kalkan Darbesi",stat:"STR"},
  shade:{name:"Gece Bıçağı",desc:"Çeviklik ve kritik vuruş ustası. Gölge Hamlesi yüksek hasar verebilir.",hp:25,mana:14,skill:"Gölge Hamlesi",stat:"DEX"},
  arcanist:{name:"Rün Bilgesi",desc:"Rün büyüleriyle yüksek büyü hasarı verir. Mana yönetimi önemlidir.",hp:21,mana:28,skill:"Rün Patlaması",stat:"INT"},
  oracle:{name:"Kül Kahini",desc:"Kehanet ve kutsal kül büyüleri kullanır; hem saldırı hem iyileştirme yapabilir.",hp:24,mana:24,skill:"Kül Mührü",stat:"WIS"}
};
const origins={
  north:{name:"Kuzey Sürgünü",bonus:"CON"},undercity:{name:"Altşehir Yetimi",bonus:"DEX"},
  academy:{name:"Kırık Akademi",bonus:"INT"},wilds:{name:"Yaban Toprakları",bonus:"WIS"}
};
let stats={}, hero={}, enemy=null, potions=2, combat=false, pendingCheck=null;
const names=["STR","DEX","CON","INT","WIS","CHA"];
function rollStat(){return Array.from({length:4},()=>1+Math.floor(Math.random()*6)).sort((a,b)=>b-a).slice(0,3).reduce((a,b)=>a+b,0)}
function mod(v){return Math.floor((v-10)/2)}
function rollStats(){
  stats={}; names.forEach(n=>stats[n]=rollStat());
  const c=classes[$("#class").value], o=origins[$("#origin").value];
  stats[c.stat]+=1; stats[o.bonus]+=1; renderStats();
}
function renderStats(){
  $("#stats").innerHTML=names.map(n=>`<div class="stat"><small>${n}</small><b>${stats[n]||0}</b><span>${mod(stats[n]||10)>=0?"+":""}${mod(stats[n]||10)}</span></div>`).join("");
}
function classInfo(){const c=classes[$("#class").value];$("#classInfo").innerHTML=`<b>${c.name}</b><br>${c.desc}`}
$("#class").onchange=()=>{classInfo();rollStats()}; $("#origin").onchange=rollStats; $("#reroll").onclick=rollStats;
classInfo(); rollStats();

function d20(){const n=1+Math.floor(Math.random()*20);$("#diceResult").textContent=n;return n}
$("#diceBtn").onclick=()=>{const r=d20(); if(pendingCheck)resolveCheck(r)};

$("#start").onclick=()=>{
  const c=classes[$("#class").value],o=origins[$("#origin").value];
  hero={name:$("#name").value.trim()||"Adsız",classKey:$("#class").value,className:c.name,origin:o.name,
    hp:c.hp+mod(stats.CON)*2,maxHp:c.hp+mod(stats.CON)*2,mana:c.mana,maxMana:c.mana,xp:0,gold:12,level:1,ac:10+mod(stats.DEX)};
  $("#creator").classList.remove("active");$("#game").classList.add("active");updateHud();sceneDoor();
};
function updateHud(){
  $("#heroName").textContent=hero.name;$("#heroMeta").textContent=`Sv. ${hero.level} · ${hero.className} · ${hero.origin}`;
  $("#hp").textContent=`${Math.max(0,hero.hp)}/${hero.maxHp}`;$("#mana").textContent=`${hero.mana}/${hero.maxMana}`;$("#xp").textContent=hero.xp;$("#gold").textContent=hero.gold;
}
function showScene(title,text,choices){
  combat=false;$("#combat").classList.add("hidden");$("#sceneTitle").textContent=title;$("#sceneText").textContent=text;
  $("#checkBox").classList.add("hidden");pendingCheck=null;
  $("#choices").innerHTML=choices.map((c,i)=>`<button data-i="${i}">${c.label}</button>`).join("");
  $$("#choices button").forEach(b=>b.onclick=()=>choices[+b.dataset.i].go());
}
function abilityCheck(stat,dc,onPass,onFail,label){
  pendingCheck={stat,dc,onPass,onFail};
  $("#checkBox").classList.remove("hidden");$("#checkBox").innerHTML=`<b>${label}</b><br>${stat} kontrolü · Zorluk ${dc}. d20 zarını at.`;
  $("#choices").innerHTML=`<button id="rollNow">d20 At</button>`;$("#rollNow").onclick=()=>resolveCheck(d20());
}
function resolveCheck(r){
  if(!pendingCheck)return;const p=pendingCheck,total=r+mod(stats[p.stat]);pendingCheck=null;
  $("#checkBox").innerHTML=`Zar: <b>${r}</b> + ${p.stat} ${mod(stats[p.stat])>=0?"+":""}${mod(stats[p.stat])} = <b>${total}</b> · ${total>=p.dc?"BAŞARILI":"BAŞARISIZ"}`;
  setTimeout(()=>total>=p.dc?p.onPass():p.onFail(),650);
}
function sceneDoor(){
  showScene("Mühürlü Kapı","Kayıp Mahzen'in girişinde, üzerinde unutulmuş bir hanedanın işareti bulunan siyah demir bir kapı yükseliyor. İçeriden metal sürtünmesine benzeyen bir ses geliyor.",[
    {label:"Kapıyı zorla (STR)",go:()=>abilityCheck("STR",12,()=>sceneHall(true),()=>{hero.hp-=3;updateHud();sceneHall(false)},"Kapıyı omzunla kır")},
    {label:"Kilidi incele (DEX)",go:()=>abilityCheck("DEX",11,()=>{hero.gold+=8;updateHud();sceneHall(true)},()=>sceneHall(false),"Eski kilidi aç")},
    {label:"Rünleri çöz (INT)",go:()=>abilityCheck("INT",12,()=>{hero.mana=Math.min(hero.maxMana,hero.mana+4);updateHud();sceneHall(true)},()=>sceneHall(false),"Kapıdaki rünleri çöz")}
  ]);
}
function sceneHall(success){
  showScene("Kemik Galerisi",success?"Kapı sessizce açılıyor. İçeride eski mezar nişleri boyunca mavi alevler yanıyor. Yerde yeni ayak izleri var.":"Kapı gürültüyle açılıyor. İçerideki bir şey seni çoktan duymuş olmalı.",[
    {label:"Ayak izlerini takip et",go:()=>startCombat({name:"Mahzen Yağmacısı",hp:24,atk:5,ac:11,xp:28,gold:14})},
    {label:"Yan geçidi araştır (WIS)",go:()=>abilityCheck("WIS",12,()=>{potions++;hero.gold+=5;updateHud();sceneShrine()},()=>startCombat({name:"Kemik Tazısı",hp:20,atk:6,ac:12,xp:25,gold:8}),"Gizli geçidi sez")}
  ]);
}
function sceneShrine(){
  showScene("Kül Mabedi","Duvarın ardındaki dar geçit seni terk edilmiş bir mabede çıkarıyor. Ortadaki taş sunağın üzerinde kalp atışı gibi titreşen kızıl bir kristal var.",[
    {label:"Kristale dokun",go:()=>abilityCheck("WIS",13,()=>{hero.maxHp+=5;hero.hp+=5;updateHud();startCombat({name:"Mühür Bekçisi",hp:31,atk:7,ac:12,xp:45,gold:24})},()=>{hero.hp-=5;updateHud();startCombat({name:"Mühür Bekçisi",hp:31,atk:7,ac:12,xp:45,gold:24})},"Kristalin iradesine diren")},
    {label:"Kristali bırak ve ilerle",go:()=>startCombat({name:"Mühür Bekçisi",hp:31,atk:7,ac:12,xp:45,gold:24})}
  ]);
}
function startCombat(e){
  combat=true;enemy={...e,maxHp:e.hp};$("#combat").classList.remove("hidden");$("#choices").innerHTML="";
  $("#enemyName").textContent=enemy.name;updateEnemy();log(`${enemy.name} gölgelerden çıkıyor.`);
}
function updateEnemy(){if(enemy)$("#enemyHp").textContent=`HP ${Math.max(0,enemy.hp)}/${enemy.maxHp}`}
function log(t){const p=document.createElement("p");p.textContent=t;$("#combatLog").prepend(p)}
$$(".combat-actions button").forEach(b=>b.onclick=()=>playerTurn(b.dataset.action));
function playerTurn(action){
  if(!combat||hero.hp<=0||enemy.hp<=0)return;
  let spentTurn=true;
  if(action==="attack"){
    const r=d20(),bonus=mod(stats[classes[hero.classKey].stat]),hit=r===20||r+bonus>=enemy.ac;
    if(hit){let dmg=Math.max(1,4+Math.floor(Math.random()*7)+bonus);if(r===20)dmg*=2;enemy.hp-=dmg;log(`Saldırı ${r+bonus}: ${dmg} hasar.`)}else log(`Saldırı ıskaladı (${r+bonus}).`);
  }else if(action==="skill"){
    if(hero.mana<5){log("Yeterli mana yok.");spentTurn=false}
    else{hero.mana-=5;const key=hero.classKey;let dmg=0;
      if(key==="warden"){dmg=6+Math.floor(Math.random()*6)+mod(stats.STR)}
      if(key==="shade"){dmg=5+Math.floor(Math.random()*10)+mod(stats.DEX)}
      if(key==="arcanist"){dmg=8+Math.floor(Math.random()*8)+mod(stats.INT)}
      if(key==="oracle"){dmg=5+Math.floor(Math.random()*7)+mod(stats.WIS);hero.hp=Math.min(hero.maxHp,hero.hp+4)}
      enemy.hp-=Math.max(1,dmg);log(`${classes[key].skill}: ${Math.max(1,dmg)} hasar.`);
    }
  }else if(action==="guard"){hero.guarding=true;log("Savunma pozisyonu aldın.")}
  else if(action==="potion"){if(potions<=0){log("İksirin kalmadı.");spentTurn=false}else{potions--;const heal=12;hero.hp=Math.min(hero.maxHp,hero.hp+heal);log(`İksir kullandın: +${heal} HP. Kalan: ${potions}`)}}  
  updateEnemy();updateHud();if(!spentTurn)return;
  if(enemy.hp<=0)return victory();
  setTimeout(enemyTurn,280);
}
function enemyTurn(){
  if(!combat)return;const r=d20(),hit=r+enemy.atk>=hero.ac;
  if(hit){let dmg=2+Math.floor(Math.random()*6)+Math.floor(enemy.atk/2);if(hero.guarding)dmg=Math.ceil(dmg/2);hero.hp-=dmg;log(`${enemy.name} ${dmg} hasar verdi.`)}else log(`${enemy.name} ıskaladı.`);
  hero.guarding=false;updateHud();if(hero.hp<=0)gameOver();
}
function victory(){
  combat=false;hero.xp+=enemy.xp;hero.gold+=enemy.gold;log(`${enemy.name} yenildi. +${enemy.xp} XP, +${enemy.gold} altın.`);
  if(hero.xp>=50*hero.level){hero.xp-=50*hero.level;hero.level++;hero.maxHp+=5;hero.hp=hero.maxHp;hero.maxMana+=3;hero.mana=hero.maxMana;log("SEVİYE ATLADIN!")}
  updateHud();setTimeout(()=>showScene("İlk Mühür Kırıldı","Düşman yere düşerken mahzenin derinliklerinden devasa bir çan sesi geliyor. Bu yalnızca ilk kattı.",[
    {label:"Mahzenin 2. katına in",go:()=>startCombat({name:"Kara Rün Şövalyesi",hp:38+hero.level*5,atk:7+hero.level,ac:13,xp:55,gold:32})},
    {label:"Kamp kur ve dinlen",go:()=>{hero.hp=hero.maxHp;hero.mana=hero.maxMana;updateHud();sceneDoor()}}
  ]),700);
}
function gameOver(){
  combat=false;showScene("Yolculuk Sona Erdi",`${hero.name}, Kayıp Mahzen'in karanlığında düştü. Ancak yeni bir kader her zaman başka bir zarla başlayabilir.`,[
    {label:"Baştan Başla",go:()=>location.reload()}
  ]);
}
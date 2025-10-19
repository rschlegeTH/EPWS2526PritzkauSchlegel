# Exposé
Robin Schlegel, Ben Pritzkau

## Projektübersicht
In Folge dieses Projekts, soll ein Spiel-System entwickelt werden, welches den Prozess der Prokrastination, die daraus entstehende Problemlage und, wenn möglich, potenzielle Lösungsansätze illustriert. Dabei soll als Grundlage Alltagsprozess verwendet werden, in welchem Pflicht und Ablenkungen vorhanden sind.

## Problemstellung
Viele Menschen prokrastinieren in ihrem Alltag und verschieben wichtige Aufgaben in die Zukunft, trotz der Tatsache, dass sie mit negativen Konsequenzen rechnen. Dieser Prozess ist für Außenstehende, und sogar betroffene, oft nicht nachvollziehbar, was die Lösung des Problems erschwert und somit für Frustration sorgt.

## Zielsetzung
Das Projekt zielt darauf ab, die Problematik der Prokrastination sichtbar zu machen und, sofern möglich, potenzielle Lösungsansätze aufzuzeigen. Mögliche Metriken zur Messung des Erfolges wären die Anzahl an Downloads, sowie die entstehenden Nutzerrezensionen.

## Aufbau und Methodik
Das Spiel versetzt den Nutzer in den Wohnraum eines Studenten, welcher in dem Raum die Auswahl zwischen verschiedenen Aktivitäten hat. Diese Aktivitäten sollen die Aufgaben und Verpflichtungen abbilden, welche häufig zu Prokrastination, sei es durch den hohen Aufwand oder ihre Ablenkungsfähigkeit, führen.
Ziel des Spielers ist das bestehend einer Abgabe, durch Erfüllung der Aufgaben.

### Spielmechaniken:
**Das freie Bewegen:**
Der Spieler ist dazu in der Lage sich innerhalb eines Raumes frei zu bewegen, und zwischen den einzelnen Aktivitäten frei zu wählen.

**Zeitmanagement:**
Der Nutzer wird ein Zeitlimit haben, innerhalb welchem es gilt, die Aufgaben abzuarbeiten. Alternativ kann der Nutzer auch eine Aktivität durchführen, welche dem Nutzer als attraktive Alternative erscheinen soll. Das Zeitlimit kann vom Nutzer überschritten werden, was zu Konsequenzen führen soll. Zu den Konsequenzen gehört der Anstieg des Stresses bei zu geringer Anzahl an erfüllten Aufgaben und ein anderes Spielende, je nach erfüllten Aufgaben.
Ein genaues Zeitmaß wird im laufe des Projekts festgesetzt werden.

**Gefühls/Gesundheitszustand:**
Der Spieler wird zwei sichtbare Parameter besitzen, dem Stresszustand und dem Gesundheitszustand. Diese beiden Zustände beeinflussen sich gegenseitig und mit den anderen Spielmechaniken wechselwirkend, nach dem Prokrastination-Gesundheitsmodel von Sirois. Das Näherkommen der Deadline mit unerfüllten Aufgaben, ungesundes Verhalten so wie nicht zu Ruhe kommen und sich kein Pausen nehmen erhöht den Stresszustand, ein hoher Stresszustand, so wie ungesundes Verhalten, erniedrigt den Gesundheitszustand und zu hoher Stresszustand sowie zu niedriger Gesundheitszustand erschweren es dem Spieler die Aufgaben zu erfüllen.

**Aufgaben:**
Aufgaben sollen als unattraktive Verpflichtung im Handlungsfokus stehen. Aufgaben verbrauchen Zeit und sind nehmen somit Einfluss auf das Zeitmanagement.
Während der Entwicklung könnten weitere Aufgaben hinzukommen.

  **Lernen/Arbeiten:**
  Diese Aufgabe soll repetitiv, langwierig und Stresserzeugend, also eine unattraktive Handlung, sein, welche es zu erfüllen gilt.
  Zudem soll das Spiel durch das Leveldesign, und visuelle Effekte wie Licht und Schatten, Inszenierung der Kamera, Geräusche oder anderen Einschränkungen den Nutzer von dem Lernen/Arbeiten abwenden, hinzu den attraktiveren Aktivitäten.

**Aktivitäten:**
Aktivitäten sollen als attraktive Alternative zu den Aufgaben dienen. Aktivitäten verbrauchen Zeit und nehmen somit Einfluss auf das Zeitmanagement.
Während der Entwicklung könnten weitere Aktivitäten hinzukommen.

  **Spiele-Konsolen Mini-Spiel:**
  Dieses Minispiel soll eine einfach spaßige Aktivität darstellen, welche von den Aufgaben ablenken soll.
  
  **Schlafen:**
  Diese Aktivität muss nach einer gewissen Menge an Zeit durchgeführt werden und verringert den Stresszustand.

**Spielenden:**
Die Spielenden sollen als Konsequenz für ein korrektes/inkorrektes Zeitmanagement dienen.

  Ende 1:
  Der Student hat die nötige Menge an Aufgaben erfüllt und besteht die Abgabe.

  Ende 2:
  Der Student hat die Aufgaben nicht erfüllt und besteht die Abgabe nicht.
## Forschungsstand
In der Forschung wird im Allgemeinen angenommen, dass Prokrastination zu einer verringerten Lern-Leistung, gesundheitlichen Defiziten und einem ungesunderen Lebensstil führt. (vgl. Jochmann et al., 2024: 11) 
Einige Modelle legen hierbei einen Zusammenhang zwischen Prokrastination, den daraus resultierenden Stress, und Krankheit nahe. (vgl. ebd.: 3)

Die genauen Prozesse, welche zu einer Minderung der negativen Konsequenzen führen, sind noch nicht genau erforscht. (vgl. ebd.) Einige Studien fanden jedoch eine Verbesserung im Umgang der Studenten mit Prokrastination, bei Verwendung von diversen Lernstrategien. (vgl. Pareira et al., 2024: 7; vgl. Khan et al., 2025: 1)

Einige Studien weisen auf ein erhöhtes auftreten von Prokrastination unter jungen Erwachsenen, insbesondere Studenten, auf. (vgl. Khan et al., 2025: 6)
Zu den häufigsten Aufgaben, welche prokrastiniert wurden, zählten akademische oder Lern-Aufgaben, sowie Haushalts-, Gesundheits-Aktivitäten und private Aufgaben. (vgl. ebd.: 3)

## Technische Umsetzung
Das Spiel wird zweidimensional gestaltet und nutzt eine Draufsicht in Pixelgrafik, vergleichbar zu Spielen wie „The Legend of Zelda: A Link to the Past“ oder „Pokémon Rote Edition“. Beispiele hierzu sind in dem Wiki des Projekts, unter „Beispiele: Technische Umsetzung“, zu finden.
**Entwicklungsumgebung:**
Das Projekt wird mittels der „Godot-Engine“ umgesetzt. Gründe hierfür sind:
1.	Das Team hat bereits kleiner Projekte mittels der Godot-Engine umgesetzt.
2.	Die Godot Engine bietet sich für kleinere Projekte, aufgrund der geringeren Komplexität, an.
3.	Die Skriptsprache GDScript basiert auf Python und ist somit zugänglich.
4.	Es gibt eine Vielzahl von Ressourcen zum Umgang mit der Engine.
5.	Die Engine läuft unter einer MIT Lizenz und verfügt somit über keine Lizenzkosten.

**Grafik:**
Die grafischen Elemente, wie Sprites, werden bei Bedarf mittels „Aseprite“ angefertigt.
1.	Das Team besitzt die Software bereits.
2.	Das Team ist vertraut mit der Software.
3.	Die Software bietet einen schnellen Workflow für das Designen von Sprites.

## Zielgruppe
Die Zielgruppe des Projekts besteht aus Personen, welche bereits Probleme mit Prokrastination haben oder mehr über die Thematik lernen und ein besseres Verständnis des Themas aufbauen wollen.
## Zeitplan
(Der Zeitplan stellt eine erste grobe Gliederung dar und kann bei Bedarf angepasst werden)

**Monat 1:**
Ausarbeitung der Problemstellung, Zielsetzung und Anforderungen sowie erste Artefakte und Proof of Concept (PoC).

**Monat 2:**
Bearbeitung der Rückmeldungen aus dem ersten Audit, Weiterentwicklung des Projekts, Spezifizierung der Anforderungen und Abschluss der Projektplanung.

**Monat 3:**
Bearbeitung der Rückmeldungen aus dem zweiten Audit, Erstellung eines vertikalen Rapid-Prototyps, Fertigstellung des PoCs und weitere Iteration des Projekts.

**Monat 4:**
Bearbeitung der Rückmeldungen aus dem dritten Audit, Fertigstellung und Verfeinerung des Prototyps, sowie Erstellung eines Posters zur Präsentation des Fachkonzepts.

## Quellen
[Godot Dokumentation](https://docs.godotengine.org/de/4.x/)

[Jochmann, A., Gusy, B., Lesener, T. et al. Procrastination, depression and anxiety symptoms in university students: a three-wave longitudinal study on the mediating role of perceived stress. BMC Psychol 12, 276 (2024).](https://doi.org/10.1186/s40359-024-01761-2) 

[Khan, S., Alzakari, M., Alsuhaibani, R. et al. Assessment of chronic procrastination in Saudi Arabia: a cross-sectional study. BMC Psychol 13, 414 (2025). ](https://doi.org/10.1186/s40359-025-02764-3)

[Pereira, M.M., Kubrusly, M., dos Santos, A.B.T.M. et al. Association between procrastination and learning strategies in medical students in a hybrid problem-based and lecture-based learning curriculum. BMC Med Educ 24, 1298 (2024). ](https://doi.org/10.1186/s12909-024-06306-0)

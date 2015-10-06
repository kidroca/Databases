# XML Basics

## What does the XML language represent? What is it used for?

* XML * stands for xStensible Markup Language. This is a universal notation containing text structured with tags, similar to the HTML structure. It's independent of hardware, OS or Programming language, and is designed to give a great amount of flexibility in marking up and passing around arbitrary data. On the web XML is normaly used for transporting data through feeds, API calls and the like XML is also frequently used for configuration files.

## Create XML document students.xml, which contains structured description of students.

## What do namespaces represent in an XML document? What are they used for?

Namespaces in XML provide a way to avoid element name conflicts when trying to mix XML document from different XML applications. Syntax:
```XML
<root
	xmlns:prefix="URI">
	<prefix:element>
		Some Data
	</prefix:element>
</root>	
```
The purpose of the "URI" is to give the namespace a unique name, it insn't used by parsers to look for information. However, companies often use the namespace as a pointer to a web page containing namespace information.

## Explore [http://en.wikipedia.org/wiki/Uniform_Resource_Identifier](http://en.wikipedia.org/wiki/Uniform_Resource_Identifier) to learn more about URI, URN and URL definitions.

## Add default namespace for students "urn:students".

## Create XSD Schema for students.xml document.

* Add new elements in the schema: information for enrollment (date and exam score) and teacher's endorsements.

## Write an XSL stylesheet to visualize the students as HTML.

* Test it in your favourite browser.
